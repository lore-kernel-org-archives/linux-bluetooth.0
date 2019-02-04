Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A13C282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103362080A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfBDTPi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:15:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:65089 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfBDTPi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 14:15:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 11:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="316262490"
Received: from ingas-nuc1.sea.intel.com ([10.251.148.183])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2019 11:15:37 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] TODO: Add Bluetooth mesh items
Date:   Mon,  4 Feb 2019 11:15:34 -0800
Message-Id: <20190204191534.5221-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 TODO | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/TODO b/TODO
index d88349e06..37462d6e8 100644
--- a/TODO
+++ b/TODO
@@ -186,3 +186,54 @@ ATT/GATT (new shared stack)
 
 Management Interface
 ====================
+
+Mesh
+====
+- Read default configuration settings (e.g., provisioning timeout, supported
+  features, etc.)from  mesh.conf file.
+
+  Priority: Medium
+  Complexity: C1
+
+- Add examples and unit tests
+
+  Priority: High
+  Complexity: C1
+
+- Implement unified feature management mechanism for mesh nodes that are hosted
+  on the same device
+
+  Priority: Medium
+  Complexity: C2
+
+- Implement mandatory Health Server model. Most likely, this will involve
+  additions to mesh D-Bus API
+
+  Priority: Medium
+  Complexity: C2
+
+- Design and implement Mesh Provisioner/ Configuration Client Model.
+
+  Priority: Medium
+  Complexity: C3
+
+- Add support for GATT proxy server
+
+  Priority: Low
+  Complexity: C3
+
+- Merge common functionality from tools/mesh. Ideally, source code from the
+  tools/mesh directory should completely dissapear.
+
+  Priority: Low
+  Complexity: C2
+
+- Support for Low Power Node (LPN)
+
+  Priority: Low
+  Complexity: C4
+
+- Support for all the Provisionings OOB styles
+
+  Priority: Medium
+  Complexity: C2
-- 
2.17.2

