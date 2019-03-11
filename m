Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF96C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8443206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCKRLF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:11:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:39288 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbfCKRLF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 13:11:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 10:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="133150665"
Received: from bgix-dell-lap.sea.intel.com ([10.251.149.88])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2019 10:11:04 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2] mesh: Fix bug with adding more than one app key
Date:   Mon, 11 Mar 2019 10:10:59 -0700
Message-Id: <20190311171059.12298-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixed problem where if the appKeys array already exists, that new add
key requests were rejected.
---
 mesh/mesh-db.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 2dc13cd65..d5d19d52f 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -533,8 +533,6 @@ bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (jarray)
-		return false;
 
 	if (jarray)
 		jentry = get_key_object(jarray, app_idx);
-- 
2.14.5

