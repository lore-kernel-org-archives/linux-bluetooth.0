Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FFC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 03:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE046207E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 03:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAVDcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:32:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:16953 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgAVDcI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 22:32:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="221113106"
Received: from ingas-nuc1.sea.intel.com ([10.254.44.219])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jan 2020 19:32:06 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] doc/mesh-api: Fix reference discrepancy for Import()
Date:   Tue, 21 Jan 2020 19:32:05 -0800
Message-Id: <20200122033205.30072-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove mentioning of ImportLocalNode() method, use Import() instead.
---
 doc/mesh-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index d83c68bdc..131de6bfd 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -222,7 +222,7 @@ Service		org.bluez.mesh
 Interface	org.bluez.mesh.Node1
 Object path	/org/bluez/mesh/node<uuid>
 		where <uuid> is the Device UUID passed to Join(),
-		CreateNetwork() or ImportLocalNode()
+		CreateNetwork() or Import()
 
 Methods:
 	void Send(object element_path, uint16 destination, uint16 key_index,
@@ -452,7 +452,7 @@ Service		org.bluez.mesh
 Interface	org.bluez.mesh.Management1
 Object path	/org/bluez/mesh/node<uuid>
 		where <uuid> is the Device UUID passed to Join(),
-		CreateNetwork() or ImportLocalNode()
+		CreateNetwork() or Import()
 
 Methods:
 	void UnprovisionedScan(uint16 seconds)
-- 
2.21.1

