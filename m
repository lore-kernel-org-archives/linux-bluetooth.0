Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72094C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEB52067D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgF3S4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:56:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:57136 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgF3S4X (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 14:56:23 -0400
IronPort-SDR: 6n+nDLIJXPhryc5ADHUtC6B5Ywy7rmeYMkZ1NsSkWpN7XQcz3es4JTAFz6YNR3Dy6+IPlXoLyy
 hvM+PjClPPFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231222959"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="231222959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 11:56:22 -0700
IronPort-SDR: q/I2bh4OLnBPF6jWSkOSnVJ/QPB/P6ZdRd94CXkvYchHp1Zd5cd+FEuCHOp+Y6fccMMIS1Qy5A
 rW/VcnMFvvmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="355864262"
Received: from mlindstr-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.108.27])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 11:56:22 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 4/4] test/test-mesh: Add options to "Models" property
Date:   Tue, 30 Jun 2020 11:56:17 -0700
Message-Id: <20200630185617.14755-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630185617.14755-1-inga.stotland@intel.com>
References: <20200630185617.14755-1-inga.stotland@intel.com>
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

