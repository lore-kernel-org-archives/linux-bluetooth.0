Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56720C76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3530C206DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 03:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGRDyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:54:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:33207 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfGRDyU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 23:54:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 20:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; 
   d="scan'208";a="168148975"
Received: from ingas-nuc1.sea.intel.com ([10.251.148.241])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2019 20:54:20 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Allow sending on org.bluez.mesh.Provisioner1
Date:   Wed, 17 Jul 2019 20:54:18 -0700
Message-Id: <20190718035418.4952-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new interface permission to bluetooth-mesh.conf:
<allow send_interface="org.bluez.mesh.Provisioner1"/>
---
 mesh/bluetooth-mesh.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/bluetooth-mesh.conf b/mesh/bluetooth-mesh.conf
index 28be7c649..7fbbd648e 100644
--- a/mesh/bluetooth-mesh.conf
+++ b/mesh/bluetooth-mesh.conf
@@ -13,6 +13,7 @@
     <allow send_interface="org.bluez.mesh.Application1"/>
     <allow send_interface="org.bluez.mesh.Element1"/>
     <allow send_interface="org.bluez.mesh.ProvisionAgent1"/>
+    <allow send_interface="org.bluez.mesh.Provisioner1"/>
   </policy>
 
   <policy context="default">
-- 
2.21.0

