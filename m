Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07474C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B272177B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgIMDeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:34:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:11485 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgIMDeA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:34:00 -0400
IronPort-SDR: RaIX+sT5IeIKAKcBQqngOq8hTgdz/pxVGO0jQJDJ4m+7e2MUHaahX3HDYdhCYeYiFAV2srljj9
 e4ZMmgwl+Eww==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="156354723"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="156354723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:33:59 -0700
IronPort-SDR: F83DnkvVUuqVntE2vnajK0+mQqjSIBUvGHL5Kq40a3B6vrtX+O+OjSL1Pc9+dDcz5+tzMDiNTq
 JzIUq0laG7kw==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347195"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:33:59 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 03/17] btio: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:27 -0700
Message-Id: <20200913033341.4639-4-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :      2

License: GPL-2.0-or-later
   btio/btio.h
   btio/btio.c
---
 btio/btio.c | 1 +
 btio/btio.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/btio/btio.c b/btio/btio.c
index 844d6007f..42874e13c 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/btio/btio.h b/btio/btio.h
index 23e0ef72b..f1f8c99a9 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.17.1

