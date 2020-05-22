Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C6C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403FE207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgEVAfE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:55682 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgEVAfE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:04 -0400
IronPort-SDR: 9p99lkuRkfCJdRVNc6VD7F/qKu4NAaiLPuG4NQyVq1EEnn27Xy7I+Zb1QRdtPLvh972g5bW4Pp
 lZDFqOo5+O/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:03 -0700
IronPort-SDR: GuUDR3dBNjbPk5xEfBeo4C1ArmehHZK0cICr1QhFFnO0acponfyq1rRgXllz8LsHQZVxQsZFHj
 GKqTfZVs7sdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961660"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:03 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 02/10] mesh: Free allocated agent in mesh_remove_agent()
Date:   Thu, 21 May 2020 17:34:53 -0700
Message-Id: <20200522003501.106165-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds previously missing call to free memory allocated
for agent structure.
---
 mesh/agent.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index a06cc2b99..4d200416f 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -188,9 +188,6 @@ static void agent_free(void *agent_data)
 	mesh_agent_key_cb_t key_cb;
 	mesh_agent_number_cb_t number_cb;
 
-	if (!l_queue_find(agents, simple_match, agent))
-		return;
-
 	err = MESH_ERROR_DOES_NOT_EXIST;
 
 	if (agent->req && agent->req->cb) {
@@ -228,15 +225,16 @@ static void agent_free(void *agent_data)
 
 	l_free(agent->path);
 	l_free(agent->owner);
+	l_free(agent);
 }
 
 void mesh_agent_remove(struct mesh_agent *agent)
 {
-	if (!agent || !l_queue_find(agents, simple_match, agent))
+	if (!agent)
 		return;
 
-	agent_free(agent);
-	l_queue_remove(agents, agent);
+	if (l_queue_remove(agents, agent))
+		agent_free(agent);
 }
 
 void mesh_agent_cleanup(void)
-- 
2.26.2

