Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD597C282CB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324220821
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 23:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfBDXbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:31:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:30428 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfBDXbF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 18:31:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 15:31:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="131542051"
Received: from rajathra-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.251.150.200])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2019 15:31:03 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] TODO: Fix complexity level for Bluetooth mesh items
Date:   Mon,  4 Feb 2019 15:31:01 -0800
Message-Id: <20190204233101.6775-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 TODO | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index 37462d6e8..598610280 100644
--- a/TODO
+++ b/TODO
@@ -215,12 +215,12 @@ Mesh
 - Design and implement Mesh Provisioner/ Configuration Client Model.
 
   Priority: Medium
-  Complexity: C3
+  Complexity: C4
 
 - Add support for GATT proxy server
 
   Priority: Low
-  Complexity: C3
+  Complexity: C4
 
 - Merge common functionality from tools/mesh. Ideally, source code from the
   tools/mesh directory should completely dissapear.
@@ -233,7 +233,7 @@ Mesh
   Priority: Low
   Complexity: C4
 
-- Support for all the Provisionings OOB styles
+- Support for all the provisioning OOB types
 
   Priority: Medium
   Complexity: C2
-- 
2.17.2

