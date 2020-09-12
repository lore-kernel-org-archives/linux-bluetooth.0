Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD91C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA83320731
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgILG32 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:29:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:11160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgILG3V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:29:21 -0400
IronPort-SDR: S7Zxnzcm0J1v/Ppkv+rE21XmFYigHEE9rZHPjP7149CTGt6T3Gm0w3tqXBGnYq0svlspjLfZuo
 7UJ2WzdG2YLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="138912322"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="138912322"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:24:18 -0700
IronPort-SDR: 3RBHlbSMhJWXoK98XTo0CTn/ZR6oP54jCLpBOYNCNX/Xzf2MCoSea2ILsCscPnrbhB1BRP/lKb
 y4jmHb7rMYfg==
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="342519251"
Received: from han1-mobl3.jf.intel.com ([10.255.228.79])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:24:18 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ 04/17] client: Add SPDX License Identifer
Date:   Fri, 11 Sep 2020 23:23:44 -0700
Message-Id: <20200912062357.23926-5-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :      9

License: GPL-2.0-or-later
   client/advertising.h
   client/display.c
   client/main.c
   client/display.h
   client/agent.h
   client/gatt.c
   client/agent.c
   client/advertising.c
   client/gatt.h
---
 client/advertising.c | 1 +
 client/advertising.h | 1 +
 client/agent.c       | 1 +
 client/agent.h       | 1 +
 client/display.c     | 1 +
 client/display.h     | 1 +
 client/gatt.c        | 1 +
 client/gatt.h        | 1 +
 client/main.c        | 1 +
 9 files changed, 9 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 1aa28e749..2bba5eca5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/advertising.h b/client/advertising.h
index 9967e657b..b2c7a1244 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/agent.c b/client/agent.c
index 4def1b478..b1e36e5d1 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/agent.h b/client/agent.h
index 30f302cdc..3ee7526db 100644
--- a/client/agent.h
+++ b/client/agent.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/display.c b/client/display.c
index 05613865b..f3d451ed8 100644
--- a/client/display.c
+++ b/client/display.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/display.h b/client/display.h
index e991d191a..9e416e9f8 100644
--- a/client/display.h
+++ b/client/display.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/gatt.c b/client/gatt.c
index e5bab6dd0..3552491d8 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/gatt.h b/client/gatt.h
index 09ca618d3..da347e06d 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/client/main.c b/client/main.c
index da877b546..abe0cf307 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.25.4

