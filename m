Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10232C43461
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE2D21D6C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgIMDeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:34:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:59032 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgIMDeC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:34:02 -0400
IronPort-SDR: P25pixIZsokZgZ0lrtJG9b9mjDfevYw5Mq4x+S3GMVWztXccLeWQKATlFrX8MGTBRYil0Evbnr
 ChqfgfwVv3ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="243784902"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="243784902"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:00 -0700
IronPort-SDR: JaCNDCOm99ghO/oZjvF+na2jO7R/PehdpR6j1FK6aq/9IPnfgm6Kce2aVFKEZU+IKCMOvv8KVu
 6DfWxQSHYBZQ==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347228"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:00 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 13/17] plugins: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:37 -0700
Message-Id: <20200913033341.4639-14-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :      7

License: GPL-2.0-or-later
   plugins/autopair.c
   plugins/hostname.c
   plugins/neard.c
   plugins/policy.c
   plugins/sixaxis.c
   plugins/wiimote.c
   plugins/external-dummy.c
---
 plugins/autopair.c       | 1 +
 plugins/external-dummy.c | 1 +
 plugins/hostname.c       | 1 +
 plugins/neard.c          | 1 +
 plugins/policy.c         | 1 +
 plugins/sixaxis.c        | 1 +
 plugins/wiimote.c        | 1 +
 7 files changed, 7 insertions(+)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 3089430a8..381d91c8f 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
index 536ad0663..78377b021 100644
--- a/plugins/external-dummy.c
+++ b/plugins/external-dummy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/plugins/hostname.c b/plugins/hostname.c
index 4f9dfe6d8..32f15b3a5 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/plugins/neard.c b/plugins/neard.c
index 6ffcd6e10..1fefc5015 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/plugins/policy.c b/plugins/policy.c
index de51e58b9..86eb25ee9 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 939fed759..8350d63f8 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 0ced27514..9441a7681 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.17.1

