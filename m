Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7AC43461
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5DE2177B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIMDeJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:34:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:59033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgIMDeD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:34:03 -0400
IronPort-SDR: 0YYVAw4L0QB+SD57SWVnQ6QrKZsgWuGD0RWcU4R/bc/t6D56YrVwM6qVTlKkqOtC2iARc49NBV
 cT/wcDfNcLTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="243784904"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="243784904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:01 -0700
IronPort-SDR: I7KWPwph3noo98XSxMflVVo1O4C7jDmFC5Ae7Vf1FU12EFx1DPqbrG1zkx/xuW9EGr8o1fGhds
 Cn6fy7EAAtfw==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347235"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:00 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 15/17] unit: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:39 -0700
Message-Id: <20200913033341.4639-16-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :     25
 LGPL-2.1-or-later    :      1
 GPL-2.0-only         :      2
 BSD-2-Clause         :      1

License: GPL-2.0-or-later
   unit/test-hog.c
   unit/test-eir.c
   unit/test-gobex-header.c
   unit/test-crc.c
   unit/test-avrcp.c
   unit/test-ringbuf.c
   unit/test-gobex-apparam.c
   unit/test-gobex.c
   unit/test-hfp.c
   unit/test-textfile.c
   unit/test-avdtp.c
   unit/test-sdp.c
   unit/test-gatt.c
   unit/test-avctp.c
   unit/test-gattrib.c
   unit/test-queue.c
   unit/test-gobex-packet.c
   unit/test-uuid.c
   unit/test-crypto.c
   unit/test-uhid.c
   unit/test-gdbus-client.c
   unit/test-midi.c
   unit/test-lib.c
   unit/test-mgmt.c
   unit/test-gobex-transfer.c

License: LGPL-2.1-or-later
   unit/test-mesh-crypto.c

License: GPL-2.0-only
   unit/util.h
   unit/util.c

License: BSD-2-Clause
   unit/test-ecc.c
---
 unit/test-avctp.c          | 1 +
 unit/test-avdtp.c          | 1 +
 unit/test-avrcp.c          | 1 +
 unit/test-crc.c            | 1 +
 unit/test-crypto.c         | 1 +
 unit/test-ecc.c            | 1 +
 unit/test-eir.c            | 1 +
 unit/test-gatt.c           | 1 +
 unit/test-gattrib.c        | 1 +
 unit/test-gdbus-client.c   | 1 +
 unit/test-gobex-apparam.c  | 1 +
 unit/test-gobex-header.c   | 1 +
 unit/test-gobex-packet.c   | 1 +
 unit/test-gobex-transfer.c | 1 +
 unit/test-gobex.c          | 1 +
 unit/test-hfp.c            | 1 +
 unit/test-hog.c            | 1 +
 unit/test-lib.c            | 1 +
 unit/test-mesh-crypto.c    | 1 +
 unit/test-mgmt.c           | 1 +
 unit/test-midi.c           | 1 +
 unit/test-queue.c          | 1 +
 unit/test-ringbuf.c        | 1 +
 unit/test-sdp.c            | 1 +
 unit/test-textfile.c       | 1 +
 unit/test-uhid.c           | 1 +
 unit/test-uuid.c           | 1 +
 unit/util.c                | 1 +
 unit/util.h                | 1 +
 29 files changed, 29 insertions(+)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index c92618bab..ca69d454e 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 13c03d037..8081b3e66 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index adf25f002..e7470ba19 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-crc.c b/unit/test-crc.c
index 791fa5137..04097eb83 100644
--- a/unit/test-crc.c
+++ b/unit/test-crc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index 46c7c0e5c..173885019 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-ecc.c b/unit/test-ecc.c
index d9136814d..e87bebf52 100644
--- a/unit/test-ecc.c
+++ b/unit/test-ecc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: BSD-2-Clause
 /*
  * Copyright (c) 2013, Kenneth MacKay
  * All rights reserved.
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 421d0db13..f6da5e6d3 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 0b77df51c..735c47da0 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 416e59635..39ac3da8c 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index ccf706713..7f1d9a32b 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
index 59393c681..2e85b1d2b 100644
--- a/unit/test-gobex-apparam.c
+++ b/unit/test-gobex-apparam.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index 3450f8123..f50c10f9c 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
diff --git a/unit/test-gobex-packet.c b/unit/test-gobex-packet.c
index d382ee5b3..1c7cb993b 100644
--- a/unit/test-gobex-packet.c
+++ b/unit/test-gobex-packet.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 3f8905c0b..61bfddef8 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 1afb7ceff..022579005 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 890eee659..f625537e8 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-hog.c b/unit/test-hog.c
index e257fbd88..66025334d 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-lib.c b/unit/test-lib.c
index 1dd5d92cf..9c4ee64c1 100644
--- a/unit/test-lib.c
+++ b/unit/test-lib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index ed37ae1a7..e65b4ee5f 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index c67678b9a..b20bd1918 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-midi.c b/unit/test-midi.c
index 593bc5a5c..66c096b46 100644
--- a/unit/test-midi.c
+++ b/unit/test-midi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-queue.c b/unit/test-queue.c
index d912a6416..c502e68da 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-ringbuf.c b/unit/test-ringbuf.c
index ef3bf0a50..f3ba2673e 100644
--- a/unit/test-ringbuf.c
+++ b/unit/test-ringbuf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 03501d021..3c40b411a 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-textfile.c b/unit/test-textfile.c
index 4b43898d6..d939443f9 100644
--- a/unit/test-textfile.c
+++ b/unit/test-textfile.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 320cd54d4..42c39a770 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 7c6789e39..e0753b816 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/unit/util.c b/unit/util.c
index c8054d2e4..31dec37df 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *
  *  OBEX library with GLib integration
diff --git a/unit/util.h b/unit/util.h
index b13fd2f16..01a482985 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *
  *  OBEX library with GLib integration
-- 
2.17.1

