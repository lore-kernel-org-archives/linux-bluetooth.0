Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B9C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 21:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058520640
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 21:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfLCVEi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:04:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:1974 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfLCVEi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 16:04:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 13:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="208575208"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.44.42])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2019 13:04:38 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        prathyusha.n@samsung.com
Subject: [PATCH BlueZ v2 3/3] mesh: Fix memory leak in Join() API call
Date:   Tue,  3 Dec 2019 13:04:10 -0800
Message-Id: <20191203210410.25548-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203210410.25548-1-brian.gix@intel.com>
References: <20191203210410.25548-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 432620a6a..6d2f86b6d 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -71,7 +71,7 @@ struct bt_mesh {
 struct join_data{
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
-	const char *sender;
+	char *sender;
 	const char *app_path;
 	struct mesh_node *node;
 	uint32_t disc_watch;
@@ -310,6 +310,7 @@ static void free_pending_join_call(bool failed)
 	if (failed)
 		node_remove(join_pending->node);
 
+	l_free(join_pending->sender);
 	l_free(join_pending);
 	join_pending = NULL;
 }
@@ -373,8 +374,10 @@ static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 	if (!join_pending)
 		return;
 
-	if (join_pending->msg)
+	if (join_pending->msg) {
 		l_dbus_message_unref(join_pending->msg);
+		join_pending->msg = NULL;
+	}
 
 	acceptor_cancel(&mesh);
 	join_pending->disc_watch = 0;
-- 
2.21.0

