Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C3DC0044D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B3720575
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 22:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgCKWP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:15:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:59190 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbgCKWP0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 18:15:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="443712658"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.76.166])
  by fmsmga006.fm.intel.com with ESMTP; 11 Mar 2020 15:15:25 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, pachoramos1@gmail.com
Subject: [PATCH BlueZ] README: Add Mesh required Kernel Configuration section
Date:   Wed, 11 Mar 2020 15:15:18 -0700
Message-Id: <20200311221518.25060-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Not all distributions include all required mesh crypto support.  This
adds a section with known kernel required options.
---
 README | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/README b/README
index c7032d02b..ad0a307f4 100644
--- a/README
+++ b/README
@@ -61,6 +61,31 @@ When neither --enable-mesh nor --enable-btpclient is specified, then this
 part is irrelevant and Embedded Linux library is not required.
 
 
+Kernel Build Options (for Mesh)
+===============================
+
+The Mesh daemon uses kernel provided crypto utilities to perform required
+security securities of Bluetooth Mesh. Many standard distributions currently
+enable all required crypto features, but a few notable distributions do
+not.
+
+If Mesh Cryptography is not working, the following configuration options
+may need to be enabled, and the kernel rebuilt.
+
+1. A minimum of kernel version 4.9 or later is required
+
+2. The kernel must at a minimum have the following .config options turned on:
+	CONFIG_CRYPTO_USER
+	CONFIG_CRYPTO_USER_API
+	CONFIG_CRYPTO_USER_API_AEAD
+	CONFIG_CRYPTO_USER_API_HASH
+
+	CONFIG_CRYPTO_AES
+	CONFIG_CRYPTO_CCM
+	CONFIG_CRYPTO_AEAD
+	CONFIG_CRYPTO_CMAC
+
+
 Configuration and options
 =========================
 
-- 
2.21.1

