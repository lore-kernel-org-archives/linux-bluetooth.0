Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEBAC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEB7207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgEVAfI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:55687 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgEVAfH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:07 -0400
IronPort-SDR: 1NYvPArfHhuoSgX+q8igRZ3DqBqb3n5LJ0spBEFdS8LWYokerXlh/qKyJlLPMHdSNw44kVYs1B
 XFSU2EzGbsmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:07 -0700
IronPort-SDR: ykPy84sq/hpIYbwmCFXpbexrXmv9QDvgLVwb6h9pUPV+kk3x68biP7rCDx/9bbgRQXQJRv9L09
 013nudNrSvOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961698"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 09/10] mesh: Fix memory leak in Create, Import & Attach methods
Date:   Thu, 21 May 2020 17:35:00 -0700
Message-Id: <20200522003501.106165-10-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This ensures that every time l_dbus_message_ref() is used to preserve
a message for a pending method reply, there is a matching call to
l_dbus_message_unref().
---
 mesh/mesh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index c68436caa..6f8974745 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -309,6 +309,7 @@ static void pending_request_exit(void *data)
 
 	reply = dbus_error(msg, MESH_ERROR_FAILED, "Failed. Exiting");
 	l_dbus_send(dbus_get_bus(), reply);
+	l_dbus_message_unref(msg);
 }
 
 static void free_pending_join_call(bool failed)
@@ -628,6 +629,7 @@ static void attach_ready_cb(void *user_data, int status, struct mesh_node *node)
 		reply = dbus_error(pending_msg, status, "Attach failed");
 
 	l_dbus_send(dbus_get_bus(), reply);
+	l_dbus_message_unref(pending_msg);
 }
 
 static struct l_dbus_message *attach_call(struct l_dbus *dbus,
@@ -700,6 +702,7 @@ static void create_node_ready_cb(void *user_data, int status,
 	if (status != MESH_ERROR_NONE) {
 		reply = dbus_error(pending_msg, status, NULL);
 		l_dbus_send(dbus_get_bus(), reply);
+		l_dbus_message_unref(pending_msg);
 		return;
 	}
 
@@ -719,6 +722,7 @@ static void create_node_ready_cb(void *user_data, int status,
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
 	dbus_send_with_timeout(dbus, msg, create_join_complete_reply_cb,
 						node, DEFAULT_DBUS_TIMEOUT);
+	l_dbus_message_unref(pending_msg);
 }
 
 static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
-- 
2.26.2

