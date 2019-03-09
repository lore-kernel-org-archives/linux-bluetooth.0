Return-Path: <SRS0=PdJ8=RM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C9C43381
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Mar 2019 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A15120645
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Mar 2019 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCISDl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:03:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:18304 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCISDl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Mar 2019 13:03:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2019 10:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,460,1544515200"; 
   d="scan'208";a="132711434"
Received: from cjschnei-mobl2.amr.corp.intel.com (HELO bgix-dell-lap.sea.intel.com) ([10.251.149.88])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2019 10:03:40 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 1/1] mesh: Fix uninitialized JSON object pointers
Date:   Sat,  9 Mar 2019 10:03:38 -0800
Message-Id: <20190309180338.31873-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix issue that allowed only a single App Key to be added
to node by remote config client.
---
 mesh/mesh-db.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 2dc13cd65..f4aa6732f 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -410,7 +410,7 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring;
+	json_object *jarray = NULL, *jentry = NULL, *jstring;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
@@ -529,12 +529,10 @@ bool mesh_db_write_device_key(json_object *jnode, uint8_t *key)
 bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring = NULL;
+	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (jarray)
-		return false;
 
 	if (jarray)
 		jentry = get_key_object(jarray, app_idx);
-- 
2.14.5

