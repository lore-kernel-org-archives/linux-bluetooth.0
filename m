Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFAC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F912073E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgF3HTm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:19:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:22973 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgF3HTl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 03:19:41 -0400
IronPort-SDR: jkwkBSdPtAQf7W47bWDfcOKW3bupA0o+n3hWrMlmrafVSnris+tA0fcCtGyxkO3up80FPITXs9
 /XU/k+brExwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133613603"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="133613603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:19:40 -0700
IronPort-SDR: yOVwbGdb52nBWtXzMgGjKCrLR15CIqjU7M5ZWxWAn8RwmKYHh8IISWmNovVOk2iO+OFw06KYka
 CMObFf0kervg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="355698485"
Received: from sdkini-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.110.226])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 00:19:40 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] test/test-mesh: Add options to "Models" property
Date:   Tue, 30 Jun 2020 00:19:36 -0700
Message-Id: <20200630071936.40437-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630071936.40437-1-inga.stotland@intel.com>
References: <20200630071936.40437-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds options dictionary to "Models" property to stay
in sync with mesh-api changes.
---
 test/test-mesh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 7c8a25482..5da0278d6 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -430,32 +430,35 @@ class Element(dbus.service.Object):
 		dbus.service.Object.__init__(self, bus, self.path)
 
 	def _get_sig_models(self):
-		ids = []
+		mods = []
 		for model in self.models:
+			opts = []
 			id = model.get_id()
 			vendor = model.get_vendor()
 			if vendor == VENDOR_ID_NONE:
-				ids.append(id)
-		return ids
+				mod = (id, opts)
+				mods.append(mod)
+		return mods
 
 	def _get_v_models(self):
-		ids = []
+		mods = []
 		for model in self.models:
+			opts = []
 			id = model.get_id()
 			v = model.get_vendor()
 			if v != VENDOR_ID_NONE:
-				vendor_id = (v, id)
-				ids.append(vendor_id)
-		return ids
+				mod = (v, id, opts)
+				mods.append(mod)
+		return mods
 
 	def get_properties(self):
 		vendor_models = self._get_v_models()
 		sig_models = self._get_sig_models()
 
 		props = {'Index' : dbus.Byte(self.index)}
-		props['Models'] = dbus.Array(sig_models, signature='q')
+		props['Models'] = dbus.Array(sig_models, signature='(qa{sv})')
 		props['VendorModels'] = dbus.Array(vendor_models,
-							signature='(qq)')
+							signature='(qqa{sv})')
 		#print(props)
 		return { MESH_ELEMENT_IFACE: props }
 
-- 
2.26.2

