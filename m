Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072D0C43461
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64D921BE5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgIMDjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:39:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:47404 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgIMDi7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:38:59 -0400
IronPort-SDR: a2I3ZEVf+kiD4rq5u+Ir636Pb2mvnU4U0awObFyy6Dkp/wYs+rMx12bGC9RBKAvargA5zHGoto
 DBKomeQ2U+Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="138973030"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="138973030"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:33:59 -0700
IronPort-SDR: PMf+aqsvCmAAAqC1i0n00Ln1pBo7Gk3rdOjNUBrKUspx+emTKvzJt3sZ5GEvRs3XKuZK202TJW
 j/gdV1MSswTw==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347206"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:33:59 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 06/17] gdbus: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:30 -0700
Message-Id: <20200913033341.4639-7-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :      6

License: GPL-2.0-or-later
   gdbus/mainloop.c
   gdbus/object.c
   gdbus/polkit.c
   gdbus/client.c
   gdbus/watch.c
   gdbus/gdbus.h
---
 gdbus/client.c   | 1 +
 gdbus/gdbus.h    | 1 +
 gdbus/mainloop.c | 1 +
 gdbus/object.c   | 1 +
 gdbus/polkit.c   | 1 +
 gdbus/watch.c    | 1 +
 6 files changed, 6 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 86e1c7693..6caa2143d 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  D-Bus helper library
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 1a601c591..60e3e8bb5 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  D-Bus helper library
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index b90a8447c..e39eeb117 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  D-Bus helper library
diff --git a/gdbus/object.c b/gdbus/object.c
index 49b578087..80ac8d7a7 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  D-Bus helper library
diff --git a/gdbus/polkit.c b/gdbus/polkit.c
index 9e95fa384..e66a50c2f 100644
--- a/gdbus/polkit.c
+++ b/gdbus/polkit.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  D-Bus helper library
diff --git a/gdbus/watch.c b/gdbus/watch.c
index 447e48671..83e8bd8be 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  D-Bus helper library
-- 
2.17.1

