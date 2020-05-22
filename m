Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86429C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D005207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgEVAfD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:55682 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgEVAfD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:03 -0400
IronPort-SDR: yPXY+8c9kkUgVoaAOj7CU9zP17cLG+ImcCowIkV7biDfThuXB/092ngaXdF3Iq10mywmJQn/jt
 hloTlZLpGGoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:03 -0700
IronPort-SDR: JmqM9Y3OvkBxK2dWKIHxHnTlvAhjFwwu1xH2+IVs470zE4Xlwsn1a6Z+zCGBKI+p8dPWg2xFGl
 pz1h2h5x6hig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961654"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:02 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 01/10] mesh: Remove unused structure member
Date:   Thu, 21 May 2020 17:34:52 -0700
Message-Id: <20200522003501.106165-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes unused "agent" member from join_data structure.
---
 mesh/mesh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 5fb9eedcf..14ac543e2 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -72,7 +72,6 @@ struct bt_mesh {
 
 struct join_data{
 	struct l_dbus_message *msg;
-	struct mesh_agent *agent;
 	char *sender;
 	struct mesh_node *node;
 	uint32_t disc_watch;
@@ -319,8 +318,6 @@ static void free_pending_join_call(bool failed)
 		l_dbus_remove_watch(dbus_get_bus(),
 						join_pending->disc_watch);
 
-	mesh_agent_remove(join_pending->agent);
-
 	if (failed)
 		node_remove(join_pending->node);
 
-- 
2.26.2

