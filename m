Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD31C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 19:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12282065D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKIT1v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:27:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:2020 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKIT1u (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 14:27:50 -0500
IronPort-SDR: O4ArIejYN8tvLpJXZYcdUSJCkO4wcI5tIZqJ60pRnuWg2ZXycHSsQxV7OUlJ6nNY72uPgjt8jL
 jq+o521nhepg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167271647"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167271647"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:27:50 -0800
IronPort-SDR: 4B0A76vp/SN/iSpFYoOA7ynbaAIaqNgZrWOeXaqfwTWQ9JVBBabpH40RzIPriYFR9r/aJUw/Wl
 oPKpakdhBhEQ==
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="473110092"
Received: from weidongc-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.212.33.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:27:50 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] client: Remove reference to g_steal_pointer()
Date:   Mon,  9 Nov 2020 11:27:42 -0800
Message-Id: <20201109192742.42207-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In order to avoid requiring higher version of GLib, replace
g_steal_pointer() with explicitly setting the pointer value
to NULL.
---
 client/adv_monitor.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 90ab0be09..8e81857af 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -254,10 +254,16 @@ void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy)
 
 void adv_monitor_remove_manager(DBusConnection *conn)
 {
-	if (manager.supported_types != NULL)
-		g_slist_free(g_steal_pointer(&(manager.supported_types)));
-	if (manager.supported_features != NULL)
-		g_slist_free(g_steal_pointer(&(manager.supported_features)));
+	if (manager.supported_types != NULL) {
+		g_slist_free(manager.supported_types);
+		manager.supported_types = NULL;
+	}
+
+	if (manager.supported_features != NULL) {
+		g_slist_free(manager.supported_features);
+		manager.supported_features = NULL;
+	}
+
 	manager.proxy = NULL;
 	manager.app_registered = FALSE;
 }
-- 
2.26.2

