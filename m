Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A0C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0212311B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRV3D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:29:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:64721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIRV3D (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 17:29:03 -0400
IronPort-SDR: 8mRZ8UHGvZ4iUyJsx4yWnOMhKypqZJc77XrKtw4e+DGBIK7Ur5BE+C9sFgi4Yvi7nNm85lWgSF
 bfx2KKyAYy8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="178125517"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="178125517"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:09:24 -0700
IronPort-SDR: UCKpPnr2ca40+9zTh2VMcQU0NIzkXdICky/hwvexc3Z3ENEid2gEsz1kmxe8ZrTi6njokveZkF
 WCH4ItzucSMw==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484378182"
Received: from han1-mobl3.jf.intel.com ([10.255.229.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:09:24 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v4 18/20] build: Add SPDX License Identifier
Date:   Fri, 18 Sep 2020 14:08:44 -0700
Message-Id: <20200918210846.37797-19-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918210846.37797-1-tedd.an@linux.intel.com>
References: <20200918210846.37797-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds SPDX License Identifier and removes the license text.

-------------------------------------
       License            COUNT
-------------------------------------
 GPL-2.0-or-later     :      6

License: GPL-2.0-or-later
   Makefile.am
   Makefile.mesh
   Makefile.obexd
   Makefile.plugins
   Makefile.tools
   configure.ac
---
 Makefile.am      | 2 +-
 Makefile.mesh    | 1 +
 Makefile.obexd   | 1 +
 Makefile.plugins | 2 +-
 Makefile.tools   | 2 +-
 configure.ac     | 1 +
 6 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 22b4fa30c..56279c4ba 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-
+# SPDX-License-Identifier: GPL-2.0
 AM_MAKEFLAGS = --no-print-directory
 AM_CPPFLAGS =
 
diff --git a/Makefile.mesh b/Makefile.mesh
index 10573b304..228dd1b5f 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 if MESH
 
 if DATAFILES
diff --git a/Makefile.obexd b/Makefile.obexd
index de59d297b..6f5dc04c0 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
diff --git a/Makefile.plugins b/Makefile.plugins
index 98eee9ec8..3b673bf85 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -1,4 +1,4 @@
-
+# SPDX-License-Identifier: GPL-2.0
 builtin_modules += hostname
 builtin_sources += plugins/hostname.c
 
diff --git a/Makefile.tools b/Makefile.tools
index e260a7f81..0423293d6 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -1,4 +1,4 @@
-
+# SPDX-License-Identifier: GPL-2.0
 if CLIENT
 bin_PROGRAMS += client/bluetoothctl
 
diff --git a/configure.ac b/configure.ac
index 292dca615..d6347c098 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 AC_PREREQ(2.60)
 AC_INIT(bluez, 5.55)
 
-- 
2.17.1

