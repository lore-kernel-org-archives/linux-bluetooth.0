Return-Path: <SRS0=aznX=T7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61482C04AB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD9526B89
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaP4q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 May 2019 11:56:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:12171 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEaP4q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 May 2019 11:56:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 08:56:46 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.230.247])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2019 08:56:45 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: ELL encrypt dependancy README section added
Date:   Fri, 31 May 2019 08:56:43 -0700
Message-Id: <20190531155643.25039-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to known AEAD encryption deficiencies in old versions of the
kernel, we have added a section on identifying and back-porting
mesh to otherwise non-supporting platforms.
---
 mesh/README | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mesh/README b/mesh/README
index 82fd5a017..f36b97c2b 100644
--- a/mesh/README
+++ b/mesh/README
@@ -71,6 +71,20 @@ Each subdirectory contains the following files:
 The node.json and node.json.bak are in JSON format. All other files are stored
 in little endian binary format.
 
+Known Issues
+============
+
+Bluetooth Mesh makes heavy usage of AEAD-AES_CCM encryption, which is
+implemented in the Linux kernel on most platforms. Some platforms, including
+those with kernel versions including and prior to v4.8, did *not* correctly
+implement the AEAD encryption routines. If Mesh is to be ported to such a
+system, it will be the responsibility of the vendor to provide support for
+AEAD-AES_CCM encryption by some other method.
+
+Support for the required AEAD routines can be determined by running the unit
+tests provided with the ELL libraries used by Mesh. Specifically, the tests
+found in .../ell/unit/test-cipher.c
+
 Information
 ===========
 
-- 
2.14.5

