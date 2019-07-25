Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF135C76190
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9776122BED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 18:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGYSb7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:31:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:57903 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGYSb5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 14:31:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 11:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="178049375"
Received: from ingas-nuc1.sea.intel.com ([10.254.183.90])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jul 2019 11:31:47 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] test/test-mesh: Initialize required properties
Date:   Thu, 25 Jul 2019 11:31:45 -0700
Message-Id: <20190725183145.23604-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This initialized required "Models" and "VendorModels" properties
wheher the actual models exist or not, according to the mesh-api.txt.
In case when an element does not contain either SIG defined models or
vendor defineed models, the corresponding properties should contain
empty arrays.
---
 test/test-mesh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 6e9196366..3c5ded7b3 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -537,10 +537,8 @@ class Element(dbus.service.Object):
 		sig_models = self._get_sig_models()
 
 		props = {'Index' : dbus.Byte(self.index)}
-		if len(sig_models) != 0:
-			props['Models'] = dbus.Array(sig_models, signature='q')
-		if len(vendor_models) != 0:
-			props['VendorModels'] = dbus.Array(vendor_models,
+		props['Models'] = dbus.Array(sig_models, signature='q')
+		props['VendorModels'] = dbus.Array(vendor_models,
 							signature='(qq)')
 		#print(props)
 		return { MESH_ELEMENT_IFACE: props }
-- 
2.21.0

