Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A2C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2774C20896
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfDAS1X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:27:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:2621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDAS1X (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 14:27:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 11:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="334011917"
Received: from bgix-dell-lap.sea.intel.com ([10.251.31.196])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2019 11:27:22 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ] build: Check if explicit_bzero is missing
Date:   Mon,  1 Apr 2019 11:27:20 -0700
Message-Id: <20190401182720.20549-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This check gets around the redefinition of explicit_bzero in ELL
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index ae64ddc0f..0afe1e6db 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,8 @@ MISC_FLAGS
 AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
 		[enable threading support]), [enable_threads=${enableval}])
 
+AC_CHECK_FUNCS(explicit_bzero)
+
 AC_CHECK_FUNC(signalfd, dummy=yes,
 			AC_MSG_ERROR(signalfd support is required))
 
-- 
2.14.5

